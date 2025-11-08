#include "esphome.h"

static const char *LOGTAG = "Utopia";

int GetTextWidth(esphome::display::Display *it, esphome::font::Font *font, const char *buffer)
{
  int x1 = 0;
  int y1 = 0;
  int width = 0;
  int height = 0;
  it->get_text_bounds(0, 0, buffer, font, TextAlign::TOP_LEFT, &x1, &y1, &width, &height);
  return width;
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
  int lines = GetNumberOfLines(text);
  PrintMultiline(it, 32, 32 - (lines * fontHeight) / 2, font, color, TextAlign::TOP_CENTER, text);
}
