# variables
var rods >= 0, <= 4000;
var angles >= 0, <= 3000;
var channels >= 0, <= 2500;

# function to maximize
maximize income: 31 * rods + 7 * angles + 74 * channels;

# constraints
subject to time_limit: rods / 200 + angles / 140 + channels / 120 <= 40;
