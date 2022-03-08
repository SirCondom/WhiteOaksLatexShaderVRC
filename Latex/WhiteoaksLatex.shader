// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "WhiteOaksShaders/WhiteoaksLatex"
{
	Properties
	{
		[Header(Wise Words Of Wizdom from friends)][Header(Oooooh Latex Sexeh    FrozenFawn)][Header(in the Wind     Gwyllgi)][Header(Error 404     Someone77 aka the nerd)][Header(Ababa    QueenLynx)][Header(Want Updates    add me on discord  WhiteOak 0001)]_CubeMap("CubeMap", CUBE) = "white" {}
		_Albedo("Albedo", 2D) = "white" {}
		_MatCap("MatCap", 2D) = "white" {}
		_EmmisionColor("Emmision Color", Color) = (0,0,0,0)
		_Emmison("Emmison", Float) = 0
		_tint("tint", Color) = (0,0,0,0)
		_Glossy("Glossy", Float) = 0
		_Matallic("Matallic", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
		[Header(Forward Rendering Options)]
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		Blend One OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 5.0
		#pragma shader_feature _GLOSSYREFLECTIONS_OFF
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float3 uv_texcoord;
		};

		uniform sampler2D _MatCap;
		uniform float4 _MatCap_ST;
		uniform float4 _tint;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform float4 _EmmisionColor;
		uniform float _Emmison;
		uniform float _Matallic;
		uniform float _Glossy;
		uniform samplerCUBE _CubeMap;
		uniform float4 _CubeMap_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_MatCap = i.uv_texcoord * _MatCap_ST.xy + _MatCap_ST.zw;
			float4 NormalMap114 = tex2D( _MatCap, uv_MatCap );
			o.Normal = NormalMap114.rgb;
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float4 Albedo30 = ( _tint * tex2D( _Albedo, uv_Albedo ) );
			o.Albedo = Albedo30.rgb;
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float4 emmisons101 = ( _EmmisionColor * ase_lightColor * float4( ase_lightColor.rgb , 0.0 ) * _Emmison );
			o.Emission = emmisons101.rgb;
			float Matallic91 = _Matallic;
			o.Metallic = Matallic91;
			float Glossy89 = _Glossy;
			o.Smoothness = Glossy89;
			float3 uv_CubeMap3 = i.uv_texcoord;
			uv_CubeMap3.xy = i.uv_texcoord.xy * _CubeMap_ST.xy + _CubeMap_ST.zw;
			float4 normal24 = texCUBE( _CubeMap, uv_CubeMap3 );
			o.Occlusion = normal24.r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
192;393;1311;666;3923.782;1653.326;4.695914;True;True
Node;AmplifyShaderEditor.CommentaryNode;31;-1690.411,-1173.411;Inherit;False;831.0199;485.52;Comment;4;28;27;29;30;Albedo;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;28;-1618.127,-1123.411;Inherit;False;Property;_tint;tint;5;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;110;-2970.585,-1064.664;Inherit;False;831.0199;485.52;Comment;2;114;111;NormalMap;1,1,1,1;0;0
Node;AmplifyShaderEditor.LightColorNode;104;-1651.308,-349.2269;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;27;-1640.412,-917.8909;Inherit;True;Property;_Albedo;Albedo;1;0;Create;True;0;0;0;False;0;False;-1;None;558d2b091691fcc4dafeaf2a1f842b96;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;105;-1682.174,-221.8677;Inherit;False;Property;_Emmison;Emmison;4;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;52;-653.3502,-254.0225;Inherit;False;439.3025;312;Comment;4;48;47;91;89;Glossy;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;96;-1650.548,-540.3155;Float;False;Property;_EmmisionColor;Emmision Color;3;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;111;-2914.514,-815.2166;Inherit;True;Property;_MatCap;MatCap;2;0;Create;True;0;0;0;False;0;False;-1;None;18bc3c3625266ef4b8fee18269619212;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;48;-603.0502,-189.099;Inherit;False;Property;_Matallic;Matallic;7;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;23;-3154.09,573.6744;Inherit;True;Property;_CubeMap;CubeMap;0;1;[Header];Create;True;6;Wise Words Of Wizdom from friends;Oooooh Latex Sexeh    FrozenFawn;in the Wind     Gwyllgi;Error 404     Someone77 aka the nerd;Ababa    QueenLynx;Want Updates    add me on discord  WhiteOak 0001;0;0;False;0;False;-1;None;1db11fa2fd2d3fe47b1f585645db2a5a;True;0;False;white;LockedToCube;False;Object;-1;Auto;Cube;8;0;SAMPLERCUBE;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;97;-1360.252,-431.4021;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-633.7607,-78.80833;Inherit;False;Property;_Glossy;Glossy;6;0;Create;True;0;0;0;False;0;False;0;0.83;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-1297.714,-1013.58;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;24;-2715.878,601.0046;Float;False;normal;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;89;-428.7743,-58.44623;Float;False;Glossy;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;101;-1182.093,-412.6464;Float;False;emmisons;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;91;-433.0854,-175.95;Float;False;Matallic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;11;-1795.02,60.64963;Inherit;False;879.6398;352.4872;Comment;4;2;3;1;8;Normal Light;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;114;-2495.167,-808.465;Float;False;NormalMap;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;30;-1083.392,-991.3124;Float;False;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;12;-1786.75,829.952;Inherit;False;859.9405;424.0627;Comment;4;5;9;4;7;Normal View;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;9;-1150.809,925.2681;Float;False;NormalDir;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;7;-1719.947,1066.015;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;8;-1139.38,131.9779;Float;False;LightDir;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;4;-1736.75,879.952;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;26;-2027.559,924.002;Inherit;False;24;normal;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;115;-72.12335,39.9312;Inherit;False;114;NormalMap;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;25;-2039.258,123.202;Inherit;False;24;normal;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.DotProductOpNode;2;-1433.02,183.2368;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;107;17.96927,250.5137;Inherit;False;89;Glossy;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;18;22.0972,-53.47217;Inherit;False;30;Albedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;90;49.8735,101.8606;Inherit;False;24;normal;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;102;47.42621,0.9985008;Inherit;False;101;emmisons;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldNormalVector;1;-1716.737,110.6496;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceLightPos;3;-1745.02,278.1369;Inherit;False;0;3;FLOAT4;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.DotProductOpNode;5;-1399.301,908.284;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;109;39.33307,192.2454;Inherit;False;91;Matallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;87;244.3253,14.0037;Float;False;True;-1;7;ASEMaterialInspector;0;0;Standard;WhiteOaksShaders/WhiteoaksLatex;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;7;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;3;1;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;97;0;96;0
WireConnection;97;1;104;0
WireConnection;97;2;104;1
WireConnection;97;3;105;0
WireConnection;29;0;28;0
WireConnection;29;1;27;0
WireConnection;24;0;23;0
WireConnection;89;0;47;0
WireConnection;101;0;97;0
WireConnection;91;0;48;0
WireConnection;114;0;111;0
WireConnection;30;0;29;0
WireConnection;9;0;5;0
WireConnection;8;0;2;0
WireConnection;4;0;26;0
WireConnection;2;0;1;0
WireConnection;2;1;3;1
WireConnection;1;0;25;0
WireConnection;5;0;4;0
WireConnection;5;1;7;0
WireConnection;87;0;18;0
WireConnection;87;1;115;0
WireConnection;87;2;102;0
WireConnection;87;3;109;0
WireConnection;87;4;107;0
WireConnection;87;5;90;0
ASEEND*/
//CHKSM=1AF7727E1FC1DBF78ED18B13EF1D2AACF1328058