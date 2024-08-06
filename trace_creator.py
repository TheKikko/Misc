# TRACE generator:
# A group of people with first names starting with TRANCE
# Want to create possible nicknames for the subgroups, e.g. when A, C and E hang out it's called ACE.
# Also, R is mostly called B, so both combinations are allowed for maximum amount of nicknames.

from itertools import permutations

# Input
members_with_R = ['T', 'R', 'A', 'C', 'E', 'N']
members_with_B = ['T', 'B', 'A', 'C', 'E', 'N']
group_members = length(members_with_B)

# Generate all permutations from 2 to n
# Permutations of length 1 are uninteresting
def generate_permutations(members):
    perms = []
    n = len(members)
    for length in range(2, n + 1):
        for p in permutations(members, length):
            perms.append(''.join(p))
    return perms

perms_with_R = generate_permutations(members_with_R)
perms_with_B = generate_permutations(members_with_B)

# Combine permutations, remove duplicates
perms = set(perms_with_R + perms_with_B)

# Save perms to separate files, one per permutation length
for i in range(2, group_members + 1): 
    subperm_i = [perm for perm in perms if len(perm) == i]
    filename = f'combinations_{i}.txt'
    with open(filename, 'w') as file:
        for perm in subperm_i:
            file.write(perm + '\n')

