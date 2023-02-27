#!/usr/bin/env bash

# Let's get the version of Elixir
# Example versions:
#  - 1.12.3
#  - 1.15.0-dev
# Example of the output of the `elixir --version` command:
# - Erlang/OTP 24 [erts-12.0.3] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [jit]
# - Elixir 1.12.3 (compiled with Erlang/OTP 24)

# Get the version!
elixir_version=$(elixir --version | tail -n1 | cut -d' ' -f2)

# Let's get the version of Erlang
erlang_version=$(erl -eval 'io:format("~s~n", [erlang:system_info(otp_release)]).' -s init stop -noshell | cut -d, -f1)

# Let's print it out
echo "Elixir version: $elixir_version, Erlang version: $erlang_version"

# Let's make PLT folder for the pair of Elixir version and Erlang version
plt_folder="$HOME/.elixir_plt/$elixir_version/$erlang_version"
mkdir -p "$plt_folder"

dialyzer --build_plt --apps erts kernel stdlib crypto public_key ssl inets mnesia sasl os_mon runtime_tools syntax_tools compiler xmerl eunit tools --output_plt "$plt_folder/erlang.plt"
