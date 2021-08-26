#!/usr/bin/python 

list1 = [1,2,3,4]
list2 = ["a","b","c","d","e"]

def merge (l1=None, l2=None,v=0):
  if v > 0: print "Merging:", l1, l2

  # Check we are given lists.  
  if type(l1) != list:
      print "ERROR: first input is not a list"
      return None
  if type(l2) != list:
      print "ERROR: seond input is not a list"
      return None

  # Get the max and min lengths of the lists
  
  len1 = len(l1)
  len2 = len(l2)
  minlen = len1
  maxlen = len2

  minlen = len1
  if len2 < minlen: minlen=len2
  maxlen = len1
  if len2 > maxlen: maxlen=len2

  # Fill both list up to the min length of each list
  both = []
  for x in range(0,minlen):
      both.extend([l1[x], l2[x]])

  # This next step is one pass through, efficient
  # Only one will append one of the lists at most. 
  if l1 > minlen:
      both.extend(l1[minlen:maxlen])
  if l2 > minlen:
      both.extend(l2[minlen:maxlen])

  return both


 # Unit testing. 
print "Answer:", merge(list1,list2)    

 #Simple testing -- should be used for unit testing. 
print "\n\nOther tests."
print merge("a", [1],v=1)
print merge("a", "b",v=1)
print merge([1], "b",v=1)
print merge(v=1)
print merge([],[],v=1)
print merge([1],[],v=1)
print merge([],[2],v=1)
