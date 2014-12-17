#pragma once

#include <string>

namespace some_module
{
class Feature
{
public:
  explicit Feature();

  virtual ~Feature();

  /*!
   * <p>Returns "Feature".</p>
   */
  std::string toString() const;

  /*!
   * <p>Returns "work".</p>
   */
  std::string work() const;
};
}
