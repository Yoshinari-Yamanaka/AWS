#include<iostream>
#include<map>

void increment(){ std::cout << "increment" << std::endl; }
void decrement(){ std::cout << "decrement" << std::endl; }

int main(int argc, char const *argv[])
{
    std::cout << "Start" << std::endl;
    std::map<std::string, void(*)()> dict = {
        {"+", &increment},
        {"-", &decrement},
    };
    dict["+"]();
    dict["-"]();
    std::cout << "Hello World" << std::endl;
    return 0;
}
