# Classic Game Collection (Home Module)
#
# Provides:
#   - Small set of lightweight, classic desktop games
#
# Included:
#   - KPat (Patience / Solitaire)
#   - KSudoku
#   - Space Cadet Pinball
#   - Palapeli (jigsaw puzzles)
#   - KMines (Minesweeper clone)
#   - KBlocks (Tetris clone)
#   - KMahjongg (Mahjong solitaire)
#
# Options:
#   - enable → Enable the Classic Game Collection
#

{ config, lib, pkgs, ... }:

let
  cfg = config.nyx-module.home.classic-game-collection;
in
{
  options.nyx-module.home.classic-game-collection = {
    enable = lib.mkEnableOption "Enable the Classic Game Collection (home module)";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      kdePackages.kpat
      kdePackages.ksudoku
      space-cadet-pinball
      kdePackages.palapeli
      kdePackages.kmines
      kdePackages.kblocks
      kdePackages.libkmahjongg
    ];
  };
}
