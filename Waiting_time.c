#include <stdio.h>
#include <stdlib.h>



int wating_time(int cp, int nt )  //nt : no. of tellers
{
    int wt;
    wt = (3*(cp + nt-1))/nt;

    if (cp == 1 && nt == 2){wt = 0;}
    if (cp == 1 && nt == 3){wt = 0;}
    if (cp == 2 && nt == 3){wt = 0;}

    return wt;
}

int main()
{

    int pc = 4;
    int num_of_tellers = 2;
    int wtime ;

    wtime = wating_time(pc,num_of_tellers);

    printf("%d",wtime);

    return 0;
}
