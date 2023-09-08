abstract class BackgroundState {
  final bool isRunning;
  BackgroundState(this.isRunning);
}
class BackgroundInitial extends BackgroundState{
  BackgroundInitial(super.isRunning);
}
class BackgroundStartSuccess extends BackgroundState{
  BackgroundStartSuccess(super.isRunning);
}