#include "esphome.h"

static const char *LOGTAG = "Utopia";

int GetTextWidth(esphome::display::Display *it, esphome::font::Font *font, std::string text)
{
  int x1 = 0;
  int y1 = 0;
  int width = 0;
  int height = 0;
  it->get_text_bounds(0, 0, text.c_str(), font, TextAlign::TOP_LEFT, &x1, &y1, &width, &height);
  return width;
}

std::vector<std::string> SplitString(const std::string &text, char ch)
{
  std::vector<std::string> words;
  size_t initialPos = 0;
  size_t pos = text.find(ch);
  while (pos != std::string::npos)
  {
    words.push_back(text.substr(initialPos, pos - initialPos));
    initialPos = pos + 1;
    pos = text.find(ch, initialPos);
  }

  // Add last word
  words.push_back(text.substr(initialPos, std::min(pos, text.size()) - initialPos + 1));
  return words;
}

std::string ConcatWithDelimiter(
    std::string first,
    std::string second,
    std::string delimiter = " ")
{
  if (first.length() == 0)
  {
    return second;
  }

  return first + delimiter + second;
}

std::string AddAutoNewline(
    esphome::display::Display *it,
    esphome::font::Font *font,
    std::string text,
    int maxWidth)
{
  std::string result = "";
  std::vector<std::string> words = SplitString(text, ' ');

  std::string currentLine = "";
  for (int idx = 0; idx < words.size(); idx++)
  {
    std::string candidateLine = ConcatWithDelimiter(currentLine, words[idx], " ");
    int len = GetTextWidth(it, font, candidateLine);
    if (len <= maxWidth)
    {
      // word fits -> take over candidate
      currentLine = candidateLine;
    }
    else
    {
      // word does not fit -> add current line to result ...
      if (currentLine.length() > 0)
      {
        result = ConcatWithDelimiter(result, currentLine, "\n");
      }

      // ... and handle the current word
      if (GetTextWidth(it, font, words[idx]) <= maxWidth)
      {
        // word fits into empty new line ->
        // set remaining part as current line
        currentLine = words[idx];
      }
      else
      {
        // handle long word that needs breaking
        for (int chars = words[idx].length(); chars > 1; chars--)
        {
          std::string subWord = words[idx].substr(0, chars);
          if (GetTextWidth(it, font, subWord) <= maxWidth)
          {
            result = ConcatWithDelimiter(result, subWord, "\n");
            currentLine = words[idx].substr(chars);
            break;
          }
        }

        // Workaround for long words: add it completely
        // result = ConcatWithDelimiter(result, words[idx], "\n");
        // currentLine = "";
      }
    }
  }

  // Print final line if any
  if (currentLine.length() > 0)
  {
    result = ConcatWithDelimiter(result, currentLine, "\n");
  }

  return result;
}

int GetNumberOfLines(std::string text)
{
  int lines = 1;
  size_t pos = text.find("\n");
  while (pos != std::string::npos)
  {
    lines++;
    pos = text.find("\n", pos + 1);
  }
  return lines;
}

// Multiline text rendering idea from here:
// https://community.home-assistant.io/t/centering-text-when-using-multiple-printf/491205/14
// https://community.home-assistant.io/t/eink-multi-line-text/255814/11
void PrintMultiline(
    esphome::display::Display *it,
    int x, int y,
    esphome::font::Font *font,
    Color color,
    TextAlign align,
    std::string text)
{

  size_t pos = text.find("\n");
  if (pos == std::string::npos)
  {
    // no newline, pint as is
    // ESP_LOGD(LOGTAG, "Print all: '%s'", text.c_str());
    it->print(x, y, font, color, align, text.c_str());
  }
  else
  {
    // Print first part
    std::string first = text.substr(0, pos);
    // ESP_LOGD(LOGTAG, "Print first: '%s'", first.c_str());
    it->print(x, y, font, color, align, first.c_str());

    std::string remain = text.substr(pos + 1);
    // ESP_LOGD(LOGTAG, "Remaining: '%s'", remain.c_str());
    Color newColor = color.gradient(Color(0, 255, 0), 64);
    PrintMultiline(it, x, y + font->get_height(), font, newColor, align, remain);
  }
}

void PrintCenteredMultiline(
    esphome::display::Display *it,
    esphome::font::Font *font,
    Color color,
    std::string text)
{
  // https://next.esphome.io/components/font/#configuration-variables
  int fontHeight = font->get_height();

  std::string multiLine = AddAutoNewline(it, font, text, 62);
  int lines = GetNumberOfLines(multiLine);
  PrintMultiline(
      it, 32, 30 - (lines * fontHeight) / 2,
      font, color, TextAlign::TOP_CENTER, multiLine);
}
