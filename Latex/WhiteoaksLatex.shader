// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "WhiteOaksShaders/WhiteoaksLatex"
{
	Properties
	{
		[Header(Wise Words Of Wizdom from friends)][Header(Oooooh Latex Sexeh    FrozenFawn)][Header(in the Wind     Gwyllgi)][Header(Error 404     Someone77 aka the nerd)][Header(Want Updates    add me on discord  WhiteOak 0001)]_MatCap("MatCap", CUBE) = "white" {}
		_Albedo("Albedo", 2D) = "white" {}
		_EmmisionColor("Emmision Color", Color) = (0,0,0,0)
		_Emmison("Emmison", Float) = 0
		_tint("tint", Color) = (0,0,0,0)
		_Mat("Mat", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
		[Header(Forward Rendering Options)]
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 5.0
		#pragma shader_feature _GLOSSYREFLECTIONS_OFF
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float3 uv_texcoord;
		};

		uniform samplerCUBE _MatCap;
		uniform float4 _MatCap_ST;
		uniform float4 _tint;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform float4 _EmmisionColor;
		uniform float _Emmison;
		uniform float _Mat;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 uv_MatCap3 = i.uv_texcoord;
			uv_MatCap3.xy = i.uv_texcoord.xy * _MatCap_ST.xy + _MatCap_ST.zw;
			float4 normal24 = texCUBE( _MatCap, uv_MatCap3 );
			float4 temp_output_90_0 = normal24;
			o.Normal = temp_output_90_0.rgb;
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
			float Reflections91 = _Mat;
			float temp_output_95_0 = Reflections91;
			o.Metallic = temp_output_95_0;
			o.Smoothness = temp_output_95_0;
			o.Occlusion = temp_output_90_0.r;
			o.Alpha = temp_output_95_0;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float3 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xyz = customInputData.uv_texcoord;
				o.customPack1.xyz = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xyz;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
333;262;1311;684;3790.713;-222.7543;1;True;True
Node;AmplifyShaderEditor.CommentaryNode;31;-1690.411,-1173.411;Inherit;False;831.0199;485.52;Comment;4;28;27;29;30;Albedo;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;28;-1618.127,-1123.411;Inherit;False;Property;_tint;tint;6;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LightColorNode;104;-1636.355,-229.6019;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;105;-1667.221,-102.2427;Inherit;False;Property;_Emmison;Emmison;5;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;52;-653.3502,-254.0225;Inherit;False;439.3025;312;Comment;4;48;47;91;89;Glossy;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;96;-1635.595,-420.6905;Float;False;Property;_EmmisionColor;Emmision Color;3;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;27;-1640.412,-917.8909;Inherit;True;Property;_Albedo;Albedo;2;0;Create;True;0;0;0;False;0;False;-1;None;558d2b091691fcc4dafeaf2a1f842b96;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;48;-603.0502,-189.099;Inherit;False;Property;_Mat;Mat;8;0;Create;True;0;0;0;False;0;False;0;1.06;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;23;-3154.09,573.6744;Inherit;True;Property;_MatCap;MatCap;0;1;[Header];Create;True;5;Wise Words Of Wizdom from friends;Oooooh Latex Sexeh    FrozenFawn;in the Wind     Gwyllgi;Error 404     Someone77 aka the nerd;Want Updates    add me on discord  WhiteOak 0001;0;0;False;0;False;-1;None;1db11fa2fd2d3fe47b1f585645db2a5a;True;0;False;white;LockedToCube;False;Object;-1;Auto;Cube;8;0;SAMPLERCUBE;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-1297.714,-1013.58;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;97;-1345.299,-311.7771;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;12;-1786.75,829.952;Inherit;False;859.9405;424.0627;Comment;4;5;9;4;7;Normal View;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;91;-318.0854,-209.95;Float;False;Reflections;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;11;-1795.02,60.64963;Inherit;False;879.6398;352.4872;Comment;4;2;3;1;8;Normal Light;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;30;-1083.392,-991.3124;Float;False;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;101;-1167.14,-293.0214;Float;False;emmisons;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;24;-2707.878,588.0046;Float;False;normal;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;7;-1719.947,1066.015;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DotProductOpNode;2;-1433.02,183.2368;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;89;-366.7743,-89.44623;Float;False;Glossy;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;93;-880.4177,389.7203;Inherit;False;91;Reflections;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceLightPos;3;-1745.02,278.1369;Inherit;False;0;3;FLOAT4;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.DotProductOpNode;5;-1399.301,908.284;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;4;-1736.75,879.952;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;74;-800.3817,208.7225;Inherit;False;Property;_noidea;noidea;4;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;8;-1139.38,131.9779;Float;False;LightDir;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-633.7607,-78.80833;Inherit;False;Property;_Spec;Spec;7;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;102;-18.57379,66.9985;Inherit;False;101;emmisons;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;75;-393.8082,348.1532;Float;False;Latex;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;18;11.0972,-14.47217;Inherit;False;30;Albedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.DotProductOpNode;92;-689.4177,358.7203;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;26;-2027.559,924.002;Inherit;False;24;normal;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;25;-2039.258,123.202;Inherit;False;24;normal;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;90;-43.1265,148.8606;Inherit;False;24;normal;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ReflectOpNode;71;-568.459,340.2548;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;9;-1150.809,925.2681;Float;False;NormalDir;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;95;-185.0775,256.7094;Inherit;False;91;Reflections;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;79;-894.6835,317.5133;Inherit;False;89;Glossy;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;1;-1716.737,110.6496;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;87;244.3253,14.0037;Float;False;True;-1;7;ASEMaterialInspector;0;0;Standard;WhiteOaksShaders/WhiteoaksLatex;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;7;Custom;0.5;True;True;0;True;Opaque;;AlphaTest;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Absolute;0;;1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;29;0;28;0
WireConnection;29;1;27;0
WireConnection;97;0;96;0
WireConnection;97;1;104;0
WireConnection;97;2;104;1
WireConnection;97;3;105;0
WireConnection;91;0;48;0
WireConnection;30;0;29;0
WireConnection;101;0;97;0
WireConnection;24;0;23;0
WireConnection;2;0;1;0
WireConnection;2;1;3;1
WireConnection;89;0;47;0
WireConnection;5;0;4;0
WireConnection;5;1;7;0
WireConnection;4;0;26;0
WireConnection;8;0;2;0
WireConnection;75;0;71;0
WireConnection;92;0;79;0
WireConnection;92;1;93;0
WireConnection;71;0;92;0
WireConnection;71;1;74;0
WireConnection;9;0;5;0
WireConnection;1;0;25;0
WireConnection;87;0;18;0
WireConnection;87;1;90;0
WireConnection;87;2;102;0
WireConnection;87;3;95;0
WireConnection;87;4;95;0
WireConnection;87;5;90;0
WireConnection;87;9;95;0
ASEEND*/
//CHKSM=37850DE5C77FF8E4E5FC63F31190C8CD443C04F2