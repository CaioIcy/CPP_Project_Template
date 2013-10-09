#pragma once

#include <string>

namespace mylib
{
class Feature
{
public:
  explicit Feature();

  virtual ~Feature();

  /*!
   * <p>Returns "Feature".</p>
   */
  std::string toString();

  /*!
   * <p>Returns "work".</p>
   */
  std::string work();
};
}
