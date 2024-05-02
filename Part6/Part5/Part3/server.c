#include <fcgi_stdio.h>
#include <stdlib.h>

void main(void)
{
    while (FCGI_Accept() >= 0)
    {
    printf("Content-type: text/html\r\n"
           "\r\n"
           "<title>CGI Hello!</title>"

           "<h1>Hello World!</h1>"
           );
    }
    exit(0);
}