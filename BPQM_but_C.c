#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <conio.h>

#define up 72
#define down 80
#define ESC 27
#define rst 48    // 0 in ascii
#define Extended -32

/*
enum states
{
    Progress = 0, Empty = 1, Full = 2
};
*/

//int state = Empty;
int num_of_tellers;
int client;     // client number .. increament only
int cp ;        // no. of  waiting persons in queue
int FF,EF ;     // flags : FullFlag , EmptyFlag


void Enter_Tellers()
{
    printf("please press any key to start\n");
    getch();
    while(1)
    {
        printf("Enter the number of tellers (1 or 2 or 3)\n");
        scanf("%d",&num_of_tellers);
        if (0<num_of_tellers && num_of_tellers<=3)
        {
            break;
        }
        else
        {
            printf("invalid input dummydummy\n");
        }
    }
}

void RST()
{
    cp = 0;
    num_of_tellers = 0;
    client = 0;
    EF = 1;
    FF = 0;
    //state = Empty;
    system("cls");
}



void countupordown(char ch)
{
    if(ch == up)
    {
        if(cp == 7)
        {
            cp = 7 ;
            FF = 1 ;
            EF = 0 ;
        }
        else
        {
            cp++ ;
            EF = 0 ;
            FF = 0 ;
            client ++;
        }

    }
    else if(ch == down)
    {
        if(cp==0)
        {
            cp = 0 ;
            EF = 1 ;
            FF = 0 ;
        }
        else
        {
            cp-- ;
            EF = 0 ;
            FF = 0 ;
        }
    }
}

int wating_time(int cp, int nt )  //nt : no. of tellers
{
    int wt;
    wt = (3*(cp + nt-1))/nt;
    if (cp == 1 && nt == 2)
    {
        wt = 0;
    }
    if (cp == 1 && nt == 3)
    {
        wt = 0;
    }
    if (cp == 2 && nt == 3)
    {
        wt = 0;
    }
    return wt;
}


void FSM(int FF, int EF)
{
    int wt ;
    if( FF == 1 && EF == 0 )
    {
        system("cls");
        printf("The queue is Full , cant get anymore clients\n");
        wt = wating_time(cp,num_of_tellers);
        printf("the client number is : %d\n",client);
        printf("the no. of waiting clients in queue : %d\n",cp);
        printf("the waiting time for the last client Entered : %d mins\n",wt);

    }
    else if( FF == 0 && EF == 1 )
    {
        system("cls");
        printf("The queue is Empty for now.\n");

    }
    else if( FF == 0 && EF == 0 )
    {
        system("cls");
        printf("The queue is in progress\n");
        wt = wating_time(cp,num_of_tellers);
        printf("the client number is : %d\n",client);
        printf("the no. of waiting clients in queue : %d\n",cp);
        printf("the waiting time for the last client : %d mins\n",wt);
    }
    else
    {
        RST();
        printf("Reseting....");
        getch();
    }

}


int main()
{
    char ch ;
    int _exit = 0 ;
    RST();
    Enter_Tellers();

    do
    {
        _flushall();
        printf("Waiting for your progress !\n");
        ch = getch();

        switch(ch)
        {
        case Extended :
            ch = getch();
            _flushall();
            switch(ch)
            {
            case up :
            case down :
                countupordown(ch);
                //printf("%d",cp);
                break;
            default :
                printf("wrong input dummydummy\n");
                break;
            }
            break;

        case rst :
            RST();
            Enter_Tellers();
            _flushall();
            break;
        case ESC :
            _exit = 1 ;
            _flushall();
            break;
        default :
            printf("invalid input dummydummy\n");
            break;
        }

        FSM(FF,EF);


    }
    while(_exit == 0);

    system("cls");
    printf("Cya next day :3");

    return 0;
}
