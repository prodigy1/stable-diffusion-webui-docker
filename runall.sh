#!/bin/bash
AUTO_SHA=$(curl -s https://api.github.com/repos/AUTOMATIC1111/stable-diffusion-webui/git/trees/master | jq -r .sha)
INVOKE_SHA=$(curl -s https://api.github.com/repos/invoke-ai/InvokeAI/git/trees/main | jq -r .sha)
SYGIL_SHA=$(curl -s https://api.github.com/repos/Sygil-Dev/sygil-webui/git/trees/master | jq -r .sha)

if grep 'AUTO_SHA' .env > /dev/null
then
  sed -i "s/AUTO_SHA=.*$/AUTO_SHA=${AUTO_SHA}/" .env
else
  echo "AUTO_SHA=${AUTO_SHA}" >> .env
fi
if grep 'INVOKE_SHA' .env > /dev/null
then
  sed -i "s/INVOKE_SHA=.*$/INVOKE_SHA=${INVOKE_SHA}/" .env
else
  echo "INVOKE_SHA=${INVOKE_SHA}" >> .env
fi
if grep 'SYGIL_SHA' .env > /dev/null
then
  sed -i "s/SYGIL_SHA=.*$/SYGIL_SHA=${SYGIL_SHA}/" .env
else
  echo "SYGIL_SHA=${SYGIL_SHA}" >> .env
fi

docker compose --profile all up --build -d
