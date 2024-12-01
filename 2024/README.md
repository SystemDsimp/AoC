# 2024

If you want to try out my terrible code just install the nix package manager from:
https://nixos.org/download/

Then run:
```bash
nix develop --extra-experimental-features nix-command --extra-experimental-features flakes
```

You will be dropped in a shell with the correct version of Elixir/OTP installed :3

`cd` into a specific days directory and call `elixir <program-name>.exs`