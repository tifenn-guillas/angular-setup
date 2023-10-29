if [ ! -f package.json ]; then
  ng new angular-setup --no-interactive --package-manager yarn --routing --skip-git
  mv angular-setup/{.,}* .
  rmdir angular-setup
else
  yarn
fi
