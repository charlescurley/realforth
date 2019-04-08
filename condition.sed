# Use this sed command to strip control Ms and other nasties out of
# Atari, MS-DOS and other listings prior to checking them in. E.g., in
# the atari directory:

# sed -i~ -f ../condition.sed atari.cross.compile.txt

# So far, anyway, we leave the page characters in.

s/\x0d//g          # Carriage returns.
s/\x00/ /g         # to get the null word name in vocabulary listings.
