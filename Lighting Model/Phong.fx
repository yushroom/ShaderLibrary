float4x4 matWorld : World;
float4x4 matWorldViewProjection : ViewProjection;
float4x4 matWorldInverseTranspose : WorldInverseTranspose;

struct VS_INPUT
{
	float3 Pos : POSITION;
	float3 Normal : NORMAL;
};

struct VS_OUTPUT
{
	float4 Pos : POSITION;
	float3 PosW : TEXCOORD;
	float3 Normal : NORMAL;
};

VS_OUTPUT vs_main(VS_INPUT In)
{
	VS_OUTPUT Out = (VS_OUTPUT)0;

	Out.PosW = mul( float4(In.Pos, 1), matWorld ).xyz;
	Out.Pos = mul( float4(In.Pos, 1), matWorldViewProjection );
	Out.Normal = normalize( mul(In.Normal, (float3x3)matWorldInverseTranspose ) );
	return Out;
}

// Point Light
float3 LightPos = {10, 10, 0};
float3 LightColor = {1, 1, 1};

// Eye
float4 vViewPosition;

float3 globalAmbient = {0.3, 0.3, 0.3};

float ka = 0.5;
float kd = 0.5;
float ks = 0.8;
float shininess = 128;

float4 ps_main(VS_OUTPUT In) : COLOR
{
	float3 N = normalize(In.Normal);
	float3 L = normalize(In.PosW - LightPos);
	float3 V = normalize(vViewPosition.xyz - In.PosW);
	float3 R = normalize(reflect(-L, N));

	float dotVR = max( dot(V, R), 0);
	float dotNL = max( dot(N, L), 0);

	float3 ambient = ka * globalAmbient;
	float3 diffuse = kd * LightColor * dotNL;
	float3 specular = ks * LightColor * pow(dotVR, shininess);

	return float4(ambient + diffuse + specular, 1);
}