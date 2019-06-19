#!/usr/bin/python

""" This ia a program. """
import logging
import argparse
import sys

class MyClass():
    """ Generic class"""
    a = 100
    b = 50
    logging.basicConfig(level=logging.DEBUG,
                        filename = "test.log",
                         filemode='a',
                    format='%(asctime)s %(module)s %(name)s.%(funcName)s +%(lineno)s: %(levelname)-8s [%(process)d] %(message)s',
                    )


    console = logging.StreamHandler()
    console.setLevel(logging.DEBUG)
    formatter = logging.Formatter('%(name)-12s: %(levelname)-8s %(message)s')
    console.setFormatter(formatter)
    
    logging.getLogger('').addHandler(console)
    logger = logging.getLogger()
    
    def __init__ (self,  *args, **kwargs):
        if len(args) == 2:
            self.a = args[0]
            self.b = args[1]
        elif kwargs.has_key("a") or kwargs.has_key("b"):
          if kwargs.has_key("a"): self.a = kwargs["a"]
          if kwargs.has_key("b"): self.b = kwargs["b"]

    def error(self, e = None, message= None):
        if len(str(message)) > 0:
            self.logger.debug(str(message) + "\n")
            self.logger.debug(str(e) + "\n")
        if e is None:
            self.logger.debug("ERROR: no e given to log.\n")
        else:    
            self.logger.exception(str(e))
        
    def log(self, message=None):
        if len(str(message)) > 0:
            self.logger.debug(str(message) + "\n")
      
    
    def myfunc(self, a=None, b=None):
        if a is not None: self.a = a
        if b is not None: self.b = b
             
        try:
           c = self.a/self.b
           message = str(self.a) + "/" + str(self.b) + "=" + str(c)
           self.log(message = message)
        except Exception as e:
           self.error(e=e, message = "ERROR: division " + str([self.a,self.b]) + "\n")

test1 = MyClass(a=101,b=201)
test1.myfunc()
test1.myfunc(1,0)
test1.myfunc(2,1)


sys.exit()
parser = argparse.ArgumentParser()
parser.add_argument('a')
parser.add_argument('b')
args = parser.parse_args()
c1 = MyClass(args.a, args.b)
