namespace TextureFix {
	public class TextureFix : ResoniteModLoader.ResoniteMod {
		public override string Name => "TextureFix";
		public override string Author => "rcelyte";
		public override string Version => "1.0.0";
		public override string Link => "https://github.com/rcelyte/ResoniteTextureFix/";
		public override void OnEngineInit() =>
			new HarmonyLib.Harmony("org.rcelyte.TextureFix").PatchAll();

		[HarmonyLib.HarmonyPatch(typeof(UnityFrooxEngineRunner.Helper), nameof(UnityFrooxEngineRunner.Helper.ToOpenGL), new[] {typeof(Elements.Assets.TextureFormat), typeof(Elements.Core.ColorProfile), typeof(FrooxEngine.ISystemInfo)})]
		public class SrgbFormatPatch {
			static void Postfix(ref UnityFrooxEngineRunner.Helper.OpenGL_TextureFormat __result) {
				if(__result.baseFormat == NativeGraphics.NET.OpenGL.TextureFormat.GL_SRGB_ALPHA && !__result.isCompressed)
					__result.baseFormat = NativeGraphics.NET.OpenGL.TextureFormat.GL_RGBA;
			}
		}
	}
}
