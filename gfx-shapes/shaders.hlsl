cbuffer Uniforms : register(b2)
{
    float4x4 projectionMatrix;
    float4x4 modelViewMatrix;
};

struct VS_INOUT
{
    float4 position : SV_Position;
	float3 normal : NORMAL;
};

struct PS_OUTPUT
{
    float4 color : SV_Target;
};

VS_INOUT vertexShader(VS_INOUT input)
{
    VS_INOUT output;

    // transpose the matrices to get them into row-major format (rjd_math is column major)
    float4x4 transform = mul((modelViewMatrix), (projectionMatrix));

    output.position = mul(float4(input.position.xyz,1), transform);
	output.normal = input.normal;

    return output;
}

PS_OUTPUT pixelShader(VS_INOUT input)
{
    PS_OUTPUT output;
	output.color = float4(input.normal, 1);
    return output;
}
