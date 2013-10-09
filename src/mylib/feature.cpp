#include <mylib/feature.h>

using namespace mylib;

Feature::Feature()
{

}

Feature::~Feature()
{

}

std::string Feature::toString()
{
  char* c = new char[250];
  return "Feature";
}

std::string Feature::work()
{
  return "work";
}
