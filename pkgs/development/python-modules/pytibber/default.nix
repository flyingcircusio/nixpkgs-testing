{ lib
, aiohttp
, async-timeout
, buildPythonPackage
, fetchFromGitHub
, gql
, graphql-subscription-manager
, pytest-asyncio
, pytestCheckHook
, python-dateutil
, pythonOlder
, pytz
}:

buildPythonPackage rec {
  pname = "pytibber";
  version = "0.26.3";
  format = "setuptools";

  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "Danielhiversen";
    repo = "pyTibber";
    rev = "refs/tags/${version}";
    hash = "sha256-4yDV6tH1XSWZfcjCJ/3r4hl1n4Sbgc3x7YPE6GOfA3Y=";
  };

  propagatedBuildInputs = [
    aiohttp
    async-timeout
    gql
    graphql-subscription-manager
    python-dateutil
  ] ++ gql.optional-dependencies.websockets;

  checkInputs = [
    pytest-asyncio
    pytestCheckHook
  ];

  pytestFlagsArray = [
    "test/test.py"
  ];

  # Tests access network
  doCheck = false;

  pythonImportsCheck = [
    "tibber"
  ];

  meta = with lib; {
    description = "Python library to communicate with Tibber";
    homepage = "https://github.com/Danielhiversen/pyTibber";
    changelog = "https://github.com/Danielhiversen/pyTibber/releases/tag/${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ dotlambda ];
  };
}
