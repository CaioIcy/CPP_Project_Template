%module mylib

%rename("cpp_toString") toString;

%include std_string.i

%{
#include <mylib/feature.h>
%}

%include <mylib/feature.h>