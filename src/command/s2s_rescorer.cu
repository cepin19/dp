#include "marian.h"
#include "training/rescorer.h"

int main(int argc, char** argv) {
  using namespace marian;

  auto options = New<Config>(argc, argv, true, false);
  auto task = rescorerByType(options);

  boost::timer::cpu_timer timer;
  task->run();
  LOG(info, "Total time: {}", timer.format());

  return 0;
}
