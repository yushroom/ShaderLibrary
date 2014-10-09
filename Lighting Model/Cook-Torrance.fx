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

// Fresnel
float f0;

// Beckmann
float m;


float Beckmann(float NH, float m)
{
	float NH2 = NH * NH;
	float NH4 = NH2 * NH2;
	float m2 = m*m;

	return exp((NH2 - 1)/(m2*NH2)) / (m2 * NH4);
}

float4 ps_main(VS_OUTPUT In) : COLOR
{
	float3 N = normalize(In.Normal);
	float3 L = normalize(In.PosW - LightPos);
	float3 V = normalize(vViewPosition.xyz - In.PosW);
	float3 H = normalize(L+V);
	//float3 R = normalize(reflect(-L, N));

	//float dotVR = max( dot(V, R), 0);
	float NL = dot(N, L);
	float NH = dot(N, L);
	float NV = dot(N, V);
	float VH = dot(V, H);
	
	float3 ambient = ka * globalAmbient;
	float3 diffuse = kd * LightColor * max(NL, 0);
	float3 specular = 0;

	bool isBack = (NV > 0) && (NL > 0);
	if (isBack)
	{
		float F = f0 + (1-f0) * pow((1-VH), 5); // Fresnel reflect term
		float D = Beckmann(NH, m);				// Beckmann distribution factor -- roughness
		float G = min(2*NH*NL/VH, 2*NH*NV/VH);	// Geometric attenuation;
		G = min(1, G);
		
		specular = ks * LightColor * F*D*G / (NV * NL);
	}

	return float4(ambient + diffuse + specular, 1);
}