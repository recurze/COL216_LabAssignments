#include <iostream>

inline void sumOfsqOfDigits(int &n){
    int sum=0, rem;
    while(n){
        rem=n%10;
        n/=10;
        sum+=(rem*rem);
    }
    n=sum;
}

int main(int argc, char const *argv[]) {
    int temp;
    for(int i=1; i<10000; ++i){
        temp=i;
        while(temp>9) sumOfsqOfDigits(temp);
        if(temp%6==1){
            std::cout<<i<<'\n';
        }
    }
    return 0;
}
