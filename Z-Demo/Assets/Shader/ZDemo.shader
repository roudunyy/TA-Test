Shader "Custom/ZDemo"
{
    Properties
    {
        _MainColor ("Color", Color) = (1,1,1,1)
        [HideInInspector]_MainTex ("Albedo (RGB)", 2D) = "white" {}
        [Enum(Off, 0, On, 1)]_ZWriteMode("ZWrite Mode", Float) = 1
        [Enum(UnityEngine.Rendering.CompareFunction)] _ZComp("ZTest Comp", Float) = 4
    }
    SubShader
    {
        Pass
        {
            Tags {"RenderType" = "Opaque" "Queue" = "Geometry"}
            ZWrite [_ZWriteMode]
            ZTest [_ZComp]
            Cull Off

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // #pragma multi_compile_fog

            #include "UnityCG.cginc"
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                // UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _MainColor;
        
            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                // UNITY_TRANSFER_FOG(O, o.vertex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                half4 col = _MainColor;
                // UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}