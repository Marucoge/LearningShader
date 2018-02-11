Shader "Custom/FirstShader" {		// シェーダーのディレクトリ位置と名前を記述している。

	// Materialのパラメータを設定するためのプロパティ。
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
	}

	// 実際に実行されるシェーダ。
	// 実行できなかった場合は次のSubShaderが実行される。すべてだめならFallBackに記述してあるシェーダを探しに行く。
	SubShader {
		Tags { "RenderType"="Opaque" }	// シェーダの分類。
		LOD 200		// Level Of Detail を意味する。LOD値が200以上ならこのシェーダは描画してもいいよということらしい。

		CGPROGRAM		// CGPROGRAMからENDCGまでがプログラムの中身となる。
		
		#pragma surface surf Standard fullforwardshadows		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma target 3.0		// Use shader model 3.0 target, to get nicer looking lighting
		sampler2D _MainTex;			// _MainTexという名前のテクスチャを使う、ということらしい。

		// 構造体を定義している。これを後で surf関数の引数として使う。
		// _MainTexのuv座標を取得している(?)らしい。
		struct Input {
			float2 uv_MainTex;
		};

		// half は半精度浮動小数点数、fixedは固定小数点数、fixed4はその4要素ベクトル版、floatは単精度浮動小数点数
		// PCのGPUでは全てfloatとして実行される?
		half _Glossiness;		// Smoothnessのこと。
		half _Metallic;
		fixed4 _Color;

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
		UNITY_INSTANCING_BUFFER_END(Props)			// put more per-instance properties here

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// テクスチャの1ピクセルのことを texel と呼んだりする。
			// テクスチャから texel を取り出すことを Fetch という。
			// tex2D関数を使い、テクスチャからTexelをFetchして、_Colorを乗算している。
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;		// Albedo comes from a texture tinted by color

			// あとはパラメータを SourfaceOutputStandard構造体に渡しているだけ。
			// この構造体が Standard(Lighting)関数に送られ、ライティング計算がされ、最終的に1ピクセルの色として画面に出力される。
			o.Albedo = c.rgb;
			o.Metallic = _Metallic;		// Metallic and smoothness come from slider variables
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
