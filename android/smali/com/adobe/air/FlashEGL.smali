.class public interface abstract Lcom/adobe/air/FlashEGL;
.super Ljava/lang/Object;
.source "FlashEGL.java"


# virtual methods
.method public abstract CreateDummySurfaceAndContext()I
.end method

.method public abstract CreateGLContext(Z)I
.end method

.method public abstract CreateWindowSurface(Landroid/view/SurfaceView;I)I
.end method

.method public abstract DestroyGLContext()Z
.end method

.method public abstract DestroyWindowSurface()Z
.end method

.method public abstract GetConfigs(ZZ)[I
.end method

.method public abstract GetNumConfigs()[I
.end method

.method public abstract GetSurfaceHeight()I
.end method

.method public abstract GetSurfaceWidth()I
.end method

.method public abstract HasGLContext()Z
.end method

.method public abstract InitEGL()I
.end method

.method public abstract IsARGBSurface()Z
.end method

.method public abstract IsBufferPreserve()Z
.end method

.method public abstract IsEmulator()Z
.end method

.method public abstract MakeGLCurrent()I
.end method

.method public abstract ReleaseGPUResources()V
.end method

.method public abstract SetConfig(I)V
.end method

.method public abstract SwapEGLBuffers()V
.end method

.method public abstract TerminateEGL()V
.end method
