Feature: Dual scoring in scenarios
  Race sessions should display both performance and style results so that speed-focused and drift-focused players are rewarded.

  Scenario: Track drift and race scores for participants
    Given a multiplayer race with registered participants
    When a participant completes race checkpoints and triggers drift events
    Then the race leaderboard should include their race progress
    And the same leaderboard should include their accumulated drift score

  Scenario: Ignore drift scores from non-participants
    Given an active race with a defined participant list
    When a non-participant reports a drift score
    Then the leaderboard drift column should remain unchanged for official racers

  Scenario: Reset drift scores when a new race starts
    Given a completed race with stored drift totals
    When a new race round begins with a fresh participant roster
    Then all tracked drift scores start at zero
