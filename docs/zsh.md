
# Zsh Configuration

This document outlines the FZF (Fuzzy Finder) customizations within the Zsh setup, focusing on keybindings and enhanced completion functions.

## FZF Keybindings and Previews

FZF is integrated with several keybindings to provide fuzzy search capabilities with live previews:

*   **`CTRL-T` (File/Directory Selection)**: Launches FZF to select files or directories, with a preview of the selected item.
*   **`ALT-C` (Directory Selection)**: Similar to `CTRL-T`, but specifically for selecting directories, also with a live preview.

## Custom FZF Completion Functions

The following custom completion functions enhance FZF's behavior for specific commands, often including interactive previews:

*   **`docker`**: Provides completions for Docker commands (images and containers) with detailed previews.
*   **`git`**: Enhances Git command completions (e.g., branches for checkout/diff) with commit log previews.
*   **`glab`**: Provides completions for GitLab CLI commands (e.g., merge requests) with detailed MR previews.
*   **`ps`**: Offers process selection with detailed process information previews.
*   **`export` / `unset`**: Provides completions and previews for environment variables.
*   **`ssh`**: Offers completions for SSH hosts with `dig` previews.
