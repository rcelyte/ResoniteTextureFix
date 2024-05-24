CSC ?= csc

sinclude makefile.user

ifdef RESONITEDIR
else
gamedir:
	$(error Resonite path not set)
endif

TextureFix.dll: TextureFix.cs | gamedir
	$(CSC) -nologo -t:library -nostdlib -o+ -debug- -nullable+ -w:4 -warnaserror+ -langversion:9 $< -out:$@ \
		-r:$(RESONITEDIR)/Resonite_Data/Managed/mscorlib.dll -r:$(RESONITEDIR)/Resonite_Data/Managed/Elements.Core.dll -r:$(RESONITEDIR)/Resonite_Data/Managed/Elements.Assets.dll \
		-r:$(RESONITEDIR)/Resonite_Data/Managed/FrooxEngine.dll -r:$(RESONITEDIR)/Resonite_Data/Managed/UnityFrooxEngineRunner.dll -r:$(RESONITEDIR)/Resonite_Data/Managed/NativeGraphics.NET.dll \
		-r:$(RESONITEDIR)/Libraries/ResoniteModLoader.dll -r:$(RESONITEDIR)/rml_libs/0Harmony.dll

clean:
	$(RM) TextureFix.dll

install: TextureFix.dll | gamedir
	cp $< $(RESONITEDIR)/rml_mods

.PHONY: clean install gamedir
