{ lib
, buildPythonPackage
, fetchFromGitHub
, isPy27
, future
, fsspec
, numpy
, packaging
, pytestCheckHook
, torch
, pyyaml
, tensorboard
, torchmetrics
, tqdm }:

buildPythonPackage rec {
  pname = "pytorch-lightning";
  version = "1.6.3";

  disabled = isPy27;

  src = fetchFromGitHub {
    owner = "Lightning-AI";
    repo = "lightning";
    rev = "refs/tags/${version}";
    sha256 = "0ppdjykz1p70zn21yyp3w2iqmlr4bz7zdhh6gx89kjrq7yp0ai9h";
  };

  propagatedBuildInputs = [
    packaging
    future
    fsspec
    numpy
    torch
    pyyaml
    tensorboard
    torchmetrics
    tqdm
  ];

  checkInputs = [ pytestCheckHook ];
  # Some packages are not in NixPkgs; other tests try to build distributed
  # models, which doesn't work in the sandbox.
  doCheck = false;

  pythonImportsCheck = [ "pytorch_lightning" ];

  meta = with lib; {
    description = "Lightweight PyTorch wrapper for machine learning researchers";
    homepage = "https://pytorch-lightning.readthedocs.io";
    license = licenses.asl20;
    maintainers = with maintainers; [ tbenst ];
  };
}
