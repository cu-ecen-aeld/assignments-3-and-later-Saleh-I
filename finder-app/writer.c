#include <syslog.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
    openlog(NULL, 0, LOG_USER);

    if (3 != argc)
    {
        syslog(LOG_ERR, "Invalid number of arguments, expected 2! Usage: <target> <writefile> <writestr>");
        exit(1);
    }

    syslog(LOG_DEBUG, "Writing %s to %s", argv[2], argv[1]);

    FILE *stream;
    stream = fopen(argv[1], "w");
    if (!stream)
    {
        syslog(LOG_ERR, "Specified file %s cannot be opened!", argv[1]);
        exit(1);
    }

    if (fputs(argv[2], stream) == EOF)
    {
        syslog(LOG_ERR, "Specified text: ( %s ) was not written into the file %s", argv[2], argv[1]);
        exit(1);
    }

    if (fclose(stream) == EOF)
    {
        syslog(LOG_ERR, "Couldn't close the stream for %s", argv[1]);
        exit(1);
    }

    return 0;
}
