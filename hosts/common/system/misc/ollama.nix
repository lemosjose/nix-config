{
services.ollama = {
  enable = true;
	acceleration = "rocm";
	#i prefer to keep it here just remember the value without running nix-shell for rocmPackages
	environmentVariables = { 
	  HCC_AMDGPU_TARGET = "gfx1032";
	  HSA_OVERRIDE_GFX_VERSION= "10.3.0";
	  HIP_VISIBLE_DEVICES = "0";
	};

	loadModels = [ "deepseek-r1:latest" "llama3.1:latest" ];
};
}
