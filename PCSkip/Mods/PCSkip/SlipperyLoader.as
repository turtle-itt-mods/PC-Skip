import Peanuts.Audio.HazeAudioManager.AudioManagerStatics;
import Peanuts.Triggers.PlayerTrigger;
//import Mods.PreloadFix.UI.TooltipManager;

USlipperyLoader GetSlipperyLoader() {
  	return Cast<USlipperyLoader>(Game::GetSingleton(USlipperyLoader::StaticClass()));
}

class USlipperyLoader : UHazeSingleton {
    private FString Level = "";
    private bool PreloadQueued = true;

    UFUNCTION(BlueprintOverride)
    void Initialize() {
    }

    UFUNCTION(BlueprintOverride)
    void Tick(float DeltaTime) {
        Level = GetCurrentLevel();

        if(Game::IsInLoadingScreen()) {
          QueuePreload();
        }

        if(!Game::IsInLoadingScreen() && PreloadQueued) {
            PreloadLevel();
            PreloadQueued = false;
        }
    }

    void QueuePreload() {
        PreloadQueued = true;
    }

    void PreloadLevel() {
        if(Level == "/Game/Maps/SnowGlobe/Lake/Snowglobe_Lake_BP") {
            Progress::PrepareProgressPoint("/Game/Maps/SnowGlobe/Mountain/SnowGlobe_Mountain_BP##0. Entry", FHazePrepareDone(), true);
        }
    }

}

FString GetCurrentLevel() {
    return GetAudioManager().CurrentInLevel;
}