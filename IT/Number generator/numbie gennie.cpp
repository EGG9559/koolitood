#include <iostream>
#include <random>
#include <chrono>

using namespace std;

int main() {

    random_device rd;
    auto seed = rd() ^ static_cast<unsigned long long>(
        chrono::high_resolution_clock::now().time_since_epoch().count()
    );

    mt19937 gen(seed); 
    uniform_int_distribution<> distr(200, 500);

    cout << distr(gen) << endl;

    // Keep the window open until user input
    cout << "Press Enter to exit...";
    cin.get();  // waits for user to press Enter
  
    return 0;
}
