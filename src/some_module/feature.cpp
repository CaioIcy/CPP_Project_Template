#include <some_module/feature.h>

using namespace some_module;

Feature::Feature()
{

}

Feature::~Feature()
{

}

std::string Feature::toString() const
{
  return "Feature";
}

std::string Feature::work() const
{
  return "work";
}
