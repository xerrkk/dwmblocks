static const Block blocks[] = {
    /*Icon*/    /*Command*/                                                     /*Update Interval*/  /*Update Signal*/
    {"Mem:",    "awk '/MemTotal/{t=$2*1024} /MemAvailable/{a=$2*1024} END{u=t-a; used_val=(u>=1e9?u/1e9:u/1e6); unit=(u>=1e9?\"G\":\"M\"); printf \"%.1f%s / %dGB\\n\", used_val, unit, int(t/1e9)}' /proc/meminfo",             25,                  0},


    {"",        "date '+%B %d, %I:%M%p'",                                       60,                  0},
};

static char delim[] = " - ";
static unsigned int delimLen = 5;
