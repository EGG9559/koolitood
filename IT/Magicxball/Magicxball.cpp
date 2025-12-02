#include <iostream>
#include <cstdlib>
#include <ctime>
#include <limits>   // Needed for std::numeric_limits

int main() {
    // Seed random number generator
    std::srand(static_cast<unsigned int>(std::time(nullptr)));

    // List of possible answers
    const char* answers[5] = {
        "Yes, definitely.",
        "No, certainly not.",
        "Ask again later.",
        "It’s uncertain, try again.",
        "Absolutely!"
    };

    std::string question;
    std::cout << "Ask the Magic 8-Ball a question: ";
    std::getline(std::cin, question);

    // Generate random number from 0 to 4
    int choice = std::rand() % 5;

    std::cout << "\nThe Magic 8-Ball says: " << answers[choice] << std::endl;

    std::cout << "\nPress Enter to exit...";
    // Clear any leftover input (in case user pressed Enter after question)
    std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
    std::cin.get();  // Wait for Enter before closing

    return 0;
}