float4x4 matWorld;
float4x4 matWorldViewProjection;
float4x4 matViewProjection;

float Kd = 0.7;

// Ambient light
float3 globalAmbient = {0.3, 0.3, 0.3};

// Point light
float3 lightPos = {10, 10, 0};
float3 lightColor = {1, 1, 1};

struct VS_INPUT {
	float3 Pos : POSITION;
	float3 Normal : NORMAL;
};

struct VS_OUTPUT {
	float4 Pos : POSITION;
	float3 PosW : TEXCOORD;
	float3 Normal : NORMAL;
};

VS_OUTPUT vs_main(VS_INPUT In)
{
	VS_OUTPUT Out = (VS_OUTPUT)0;

	float4 posW = mul(float4(In.Pos, 1), matWorld);
	Out.Pos = mul(posW, matViewProjection);
	Out.PosW = posW.xyz;
	Out.Normal = In.Normal;
	return Out;
}


float4 ps_main(VS_OUTPUT In) : COLOR
{
	float3 L = normalize(lightPos - In.PosW);
	float3 N = normalize(In.Normal);
	
	float3 diffuse = Kd * lightColor * max(dot(N, L), 0);
	float3 ambient = Kd * globalAmbient;

	return float4(diffuse + ambient, 1);
}