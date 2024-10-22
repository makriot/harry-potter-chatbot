#define cimg_use_png
#include "CImg.h"
#include <filesystem>
#include <fstream>
#include <string>
#include <iostream>
#include <algorithm>

namespace fs = std::filesystem;
using namespace cimg_library;

void textToImage(const std::string& inputPath, const std::string& outputPath) {
    // Read text from file
    std::ifstream file(inputPath);
    std::string text((std::istreambuf_iterator<char>(file)), std::istreambuf_iterator<char>());

    // Set up image parameters
    const int font_size = 60;  // Larger font size for more visibility
    const int padding = 10;
    const int line_length = 80;  // Approximate max characters per line
    const int lines = (text.length() / line_length) + 1;
    const int width = 2000;  // Fixed width for consistency
    const int height = (font_size + padding) * lines + padding;

    // Create an image with a black background for high contrast
    CImg<unsigned char> img(width, height, 1, 3, 0);  // Black background

    // Set up text color (white)
    unsigned char text_color[] = { 255, 255, 255 };  // White text

    // Draw text on the image with word wrapping
    int y_offset = padding;
    for (size_t i = 0; i < text.length(); i += line_length) {
        std::string line = text.substr(i, line_length);
        img.draw_text(padding, y_offset, line.c_str(), text_color, 0, 1, font_size);
        y_offset += font_size + padding;
    }

    // Save the image
    try {
        img.save(outputPath.c_str());
    } catch (const cimg_library::CImgIOException& e) {
        std::cerr << "Error saving image: " << e.what() << std::endl;
        img.save((outputPath.substr(0, outputPath.find_last_of('.')) + ".bmp").c_str());
    }
}

int main() {
    std::string input_folder = "output_raw";
    std::string output_folder = "output";

    // Create output folder if it doesn't exist
    fs::create_directories(output_folder);

    // Iterate through files in input folder
    for (const auto& entry : fs::directory_iterator(input_folder)) {
        if (entry.path().extension() == ".txt") {
            std::string inputPath = entry.path().string();
            std::string outputPath = output_folder + "/" + entry.path().stem().string() + ".png";
            
            std::cout << "Processing: " << inputPath << " -> " << outputPath << std::endl;
            
            textToImage(inputPath, outputPath);
        }
    }

    std::cout << "All files processed." << std::endl;
    return 0;
}
