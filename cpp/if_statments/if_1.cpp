
#include <iostream>
using namespace std;

int main(){

	string user_input;

	cout << "What is your input?" << endl;
	cin >> user_input;

	if (user_input == "testing"){
		cout << "Test Success" << endl;
	}
	else {
	
		cout << "Test Fail" << endl;
	}

	return 0;
}
