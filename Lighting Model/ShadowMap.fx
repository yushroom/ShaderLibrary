//**************************************************************//
//  Effect File exported by RenderMonkey 1.6
//
//  - Although many improvements were made to RenderMonkey FX  
//    file export, there are still situations that may cause   
//    compilation problems once the file is exported, such as  
//    occasional naming conflicts for methods, since FX format 
//    does not support any notions of name spaces. You need to 
//    try to create workspaces in such a way as to minimize    
//    potential naming conflicts on export.                    
//    
//  - Note that to minimize resulting name collisions in the FX 
//    file, RenderMonkey will mangle names for passes, shaders  
//    and function names as necessary to reduce name conflicts. 
//**************************************************************//

//--------------------------------------------------------------//
// ShadowMap
//--------------------------------------------------------------//
//--------------------------------------------------------------//
// Pass 0
//--------------------------------------------------------------//
string Projective_Texture_Mapping_ShadowMap_Pass_0_Hebe : ModelData = "..\\..\\..\\..\\Program Files (x86)\\AMD\\RenderMonkey 1.82\\Examples\\Media\\Models\\Hebe.3ds";

texture renderTexture_Tex : RenderColorTarget
<
   float2 ViewportRatio={1.0,1.0};
   string Format="D3DFMT_A8R8G8B8";
   float  ClearDepth=1.000000;
   int    ClearColor=-16777216;
>;
#include "Matrix.fx"
float4x4 matWorld : World : World;
float4x4 matView : View;
float4x4 matProjection;
float4x4 matWorldViewProjection : ViewProjection;
float4x4 matWorldInverseTranspose : WorldInverseTranspose : WorldInverseTranspose;

// light
float4x4 matLightView;
float4x4 matLightProjection;

float3 eye = {-80, -80, 80};
float3 lookAt = {0, 0, 0};
float3 up = {0, 0, 1};
float fov = 45;
float zn = 1;
float zf = 1000;

float fViewportWidth : ViewportWidth;
float fViewportHeight : ViewportHeight;


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

VS_OUTPUT Projective_Texture_Mapping_ShadowMap_Pass_0_Vertex_Shader_vs_main(VS_INPUT In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;
    
    float aspect = fViewportWidth / fViewportHeight;
    float4x4 mView = MatrixLookAtLH(eye, lookAt, up);
    float4x4 mProjection = MatrixPerspectiveFovLH(fov, aspect, zn, zf);
    float4x4 mWorldViewProjection = mul(mul(matWorld, matView), mProjection);

    Out.PosW   = mul( float4(In.Pos, 1), matWorld ).xyz;
    //Out.Pos     = mul( float4(In.Pos, 1), matWorldViewProjection );
    Out.Pos    = mul( float4(In.Pos, 1), mWorldViewProjection );
    Out.Normal = normalize( mul(In.Normal, (float3x3)matWorldInverseTranspose ) );
    return Out;
}
float Kd
<
   string UIName = "Kd";
   string UIWidget = "Numeric";
   bool UIVisible =  true;
   float UIMin = 0.00;
   float UIMax = 1.00;
> = float( 0.50 ) ;

// Ambient light
float3 globalAmbient
<
   string UIName = "globalAmbient";
   string UIWidget = "Numeric";
   bool UIVisible =  false;
   float UIMin = 0.00;
   float UIMax = 1.00;
> = float3( 0.30, 0.30, 0.30 ) ;

// Point light
float3 LightPos
<
   string UIName = "LightPos";
   string UIWidget = "Numeric";
   bool UIVisible =  false;
   float UIMin = -1.00;
   float UIMax = 1.00;
> = float3( -80.00, -80.00, 80.00 ) ;
float3 LightColor
<
   string UIName = "LightColor";
   string UIWidget = "Numeric";
   bool UIVisible =  false;
   float UIMin = 0.00;
   float UIMax = 1.00;
> = float3( 1.00, 1.00, 1.00 ) ;

struct Projective_Texture_Mapping_ShadowMap_Pass_0_Pixel_Shader_VS_OUTPUT {
	//float4 Pos : POSITION;
	float3 PosW : TEXCOORD;
	float3 Normal : NORMAL;
};

float4 Projective_Texture_Mapping_ShadowMap_Pass_0_Pixel_Shader_ps_main(Projective_Texture_Mapping_ShadowMap_Pass_0_Pixel_Shader_VS_OUTPUT In) : COLOR
{
	float3 L = normalize(LightPos - In.PosW);
	float3 N = normalize(In.Normal);
	
	float3 diffuse = Kd * LightColor * max(dot(N, L), 0);
	float3 ambient = Kd * globalAmbient;

	return float4(diffuse + ambient, 1);
}
//--------------------------------------------------------------//
// Pass 1
//--------------------------------------------------------------//
string Projective_Texture_Mapping_ShadowMap_Pass_1_Hebe : ModelData = "..\\..\\..\\..\\Program Files (x86)\\AMD\\RenderMonkey 1.82\\Examples\\Media\\Models\\Hebe.3ds";

float4x4 Projective_Texture_Mapping_ShadowMap_Pass_1_Vertex_Shader_matWorld : World : World;
float4x4 Projective_Texture_Mapping_ShadowMap_Pass_1_Vertex_Shader_matWorldViewProjection : WorldViewProjection : ViewProjection;
float4x4 Projective_Texture_Mapping_ShadowMap_Pass_1_Vertex_Shader_matWorldInverseTranspose : WorldInverseTranspose : WorldInverseTranspose;

struct Projective_Texture_Mapping_ShadowMap_Pass_1_Vertex_Shader_VS_INPUT
{
	float3 Pos : POSITION;
	float3 Normal : NORMAL;
};

struct Projective_Texture_Mapping_ShadowMap_Pass_1_Vertex_Shader_VS_OUTPUT
{
	float4 Pos : POSITION;
	float3 PosW : TEXCOORD;
	float3 Normal : NORMAL;
};

Projective_Texture_Mapping_ShadowMap_Pass_1_Vertex_Shader_VS_OUTPUT Projective_Texture_Mapping_ShadowMap_Pass_1_Vertex_Shader_vs_main(Projective_Texture_Mapping_ShadowMap_Pass_1_Vertex_Shader_VS_INPUT In)
{
	Projective_Texture_Mapping_ShadowMap_Pass_1_Vertex_Shader_VS_OUTPUT Out = (Projective_Texture_Mapping_ShadowMap_Pass_1_Vertex_Shader_VS_OUTPUT)0;

	Out.PosW 	= mul( float4(In.Pos, 1), Projective_Texture_Mapping_ShadowMap_Pass_1_Vertex_Shader_matWorld ).xyz;
	Out.Pos 	= mul( float4(In.Pos, 1), Projective_Texture_Mapping_ShadowMap_Pass_1_Vertex_Shader_matWorldViewProjection );
	Out.Normal 	= normalize( mul(In.Normal, (float3x3)Projective_Texture_Mapping_ShadowMap_Pass_1_Vertex_Shader_matWorldInverseTranspose ) );
	return Out;
}
float Projective_Texture_Mapping_ShadowMap_Pass_1_Pixel_Shader_Kd
<
   string UIName = "Projective_Texture_Mapping_ShadowMap_Pass_1_Pixel_Shader_Kd";
   string UIWidget = "Numeric";
   bool UIVisible =  true;
   float UIMin = 0.00;
   float UIMax = 1.00;
> = float( 0.50 ) ;

// Ambient light
float3 Projective_Texture_Mapping_ShadowMap_Pass_1_Pixel_Shader_globalAmbient
<
   string UIName = "Projective_Texture_Mapping_ShadowMap_Pass_1_Pixel_Shader_globalAmbient";
   string UIWidget = "Numeric";
   bool UIVisible =  false;
   float UIMin = 0.00;
   float UIMax = 1.00;
> = float3( 0.30, 0.30, 0.30 ) ;

// Point light
float3 Projective_Texture_Mapping_ShadowMap_Pass_1_Pixel_Shader_LightPos
<
   string UIName = "Projective_Texture_Mapping_ShadowMap_Pass_1_Pixel_Shader_LightPos";
   string UIWidget = "Numeric";
   bool UIVisible =  false;
   float UIMin = -1.00;
   float UIMax = 1.00;
> = float3( -80.00, -80.00, 80.00 ) ;
float3 Projective_Texture_Mapping_ShadowMap_Pass_1_Pixel_Shader_LightColor
<
   string UIName = "Projective_Texture_Mapping_ShadowMap_Pass_1_Pixel_Shader_LightColor";
   string UIWidget = "Numeric";
   bool UIVisible =  false;
   float UIMin = 0.00;
   float UIMax = 1.00;
> = float3( 1.00, 1.00, 1.00 ) ;

struct Projective_Texture_Mapping_ShadowMap_Pass_1_Pixel_Shader_VS_OUTPUT {
	//float4 Pos : POSITION;
	float3 PosW : TEXCOORD;
	float3 Normal : NORMAL;
};

float4 Projective_Texture_Mapping_ShadowMap_Pass_1_Pixel_Shader_ps_main(Projective_Texture_Mapping_ShadowMap_Pass_1_Pixel_Shader_VS_OUTPUT In) : COLOR
{
	float3 L = normalize(Projective_Texture_Mapping_ShadowMap_Pass_1_Pixel_Shader_LightPos - In.PosW);
	float3 N = normalize(In.Normal);
	
	float3 diffuse = Projective_Texture_Mapping_ShadowMap_Pass_1_Pixel_Shader_Kd * Projective_Texture_Mapping_ShadowMap_Pass_1_Pixel_Shader_LightColor * max(dot(N, L), 0);
	float3 ambient = Projective_Texture_Mapping_ShadowMap_Pass_1_Pixel_Shader_Kd * Projective_Texture_Mapping_ShadowMap_Pass_1_Pixel_Shader_globalAmbient;

	return float4(diffuse + ambient, 1);
}
//--------------------------------------------------------------//
// Technique Section for Effect Workspace.Projective Texture Mapping.ShadowMap
//--------------------------------------------------------------//
technique ShadowMap
{
   pass Pass_0
   <
      string Script = "RenderColorTarget0 = renderTexture_Tex;"
                      "ClearColor = (0, 0, 0, 255);"
                      "ClearDepth = 1.000000;";
   >
   {
      VertexShader = compile vs_3_0 Projective_Texture_Mapping_ShadowMap_Pass_0_Vertex_Shader_vs_main();
      PixelShader = compile ps_3_0 Projective_Texture_Mapping_ShadowMap_Pass_0_Pixel_Shader_ps_main();
   }

   pass Pass_1
   {
      VertexShader = compile vs_3_0 Projective_Texture_Mapping_ShadowMap_Pass_1_Vertex_Shader_vs_main();
      PixelShader = compile ps_3_0 Projective_Texture_Mapping_ShadowMap_Pass_1_Pixel_Shader_ps_main();
   }

}

