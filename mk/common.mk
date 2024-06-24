ifeq ($(shell uname -s),Darwin)
  PRINTF = printf
else
  PRINTF = env printf
endif

ifeq ("$(VERBOSE)","1")
    Q :=
    VECHO = @true
    REDIR =
else
    Q := @
    VECHO = @$(PRINTF)
    REDIR = >/dev/null
endif
