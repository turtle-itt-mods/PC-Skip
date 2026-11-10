@open Rice/MainMenu/MainMenu.as

@import Mods.PCSkip.SlipperyLoader;

@patch auto function UpdatePlayerSelectionStatus
    void UpdatePlayerSelectionStatus()
	{
		auto Lobby = Lobby::GetLobby();
		for (int i = 0; i < 2; ++i)
		{
			bool bSelected = false;
			if (Lobby != nullptr)
			{
				for (auto& Member : Lobby.LobbyMembers)
				{
					if (Member.Identity != nullptr && Member.ChosenPlayer == EHazePlayer(i))
						bSelected = true;
				}
			}
			if (bSelected != PrevPlayerSelectionStatus[i])
			{
				OnPlayerSelectionStatusChange.Broadcast(EHazePlayer(i), bSelected);
				PrevPlayerSelectionStatus[i] = bSelected;
			}
		}

        if(Lobby != nullptr) {
            GetSlipperyLoader().Tick(0.f);
        }
	}
@end