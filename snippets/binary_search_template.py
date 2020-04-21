"""
Author: Gaoping Huang
Created: 4/21/2020
"""

# For most binary search problem, it often takes me some time to figure out the
# lower bound and upper bound. Here is a template that would save some time.
# In this case, all elements may be covered.
def binary_search(array, target):
    n = len(array)
    lo, hi = 0, n  # note that hi is n, not n-1
    while lo < hi:  # not `<=`
        mid = (lo + hi) // 2
        value = array[mid]
        # do something with mid
        if some_condition is True:
            lo = mid + 1
        else:
            hi = mid  # just mid
    
    return

