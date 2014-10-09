//#include "Matrix.fx"
float4x4 matWorld : World;
//float4x4 matView;
//float4x4 matProjection;
//float4x4 matWorldViewProjection : ViewProjection;
float4x4 matWorldInverseTranspose : WorldInverseTranspose;

// light
float4 LightPos;
float4x4 matLightView;
float4x4 matLightProjection;

float fViewportWidth;
float fViewportHeight;

float DistanceScale;

struct VS_INPUT
{
    float3 Pos : POSITION;
};

struct VS_OUTPUT
{
    float4 Pos : POSITION;
    float2 Depth : TEXCOORD;
    float Length : TEXCOORD1;
};

VS_OUTPUT vs_main(VS_INPUT In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;
    
    float4x4 matLightWVP = mul(mul(matWorld, matLightView), matLightProjection);
    Out.Pos    = mul( float4(In.Pos, 1), matLightWVP );
    float4 PosW = mul( float4(In.Pos, 1), matWorld);
    Out.Depth = PosW.zw;
    Out.Length = length(LightPos.xyz, PosW.xyz) * DistanceScale;
    return Out;
}