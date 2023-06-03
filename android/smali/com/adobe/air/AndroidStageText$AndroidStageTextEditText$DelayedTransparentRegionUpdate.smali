.class Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText$DelayedTransparentRegionUpdate;
.super Ljava/lang/Object;
.source "AndroidStageText.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "DelayedTransparentRegionUpdate"
.end annotation


# instance fields
.field private m_AIRSurface:Lcom/adobe/air/AIRWindowSurfaceView;

.field private m_freqMsecs:I

.field private m_nUpdates:I

.field private m_stageText:Lcom/adobe/air/AndroidStageText$AndroidStageTextImpl;

.field final synthetic this$1:Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;


# direct methods
.method public constructor <init>(Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;IILcom/adobe/air/AndroidStageText$AndroidStageTextImpl;Lcom/adobe/air/AIRWindowSurfaceView;)V
    .locals 0
    .param p2, "nUpdates"    # I
    .param p3, "freqMsecs"    # I
    .param p4, "stageText"    # Lcom/adobe/air/AndroidStageText$AndroidStageTextImpl;
    .param p5, "surface"    # Lcom/adobe/air/AIRWindowSurfaceView;

    .prologue
    .line 321
    iput-object p1, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText$DelayedTransparentRegionUpdate;->this$1:Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 322
    iput p2, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText$DelayedTransparentRegionUpdate;->m_nUpdates:I

    .line 323
    iput p3, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText$DelayedTransparentRegionUpdate;->m_freqMsecs:I

    .line 324
    iput-object p4, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText$DelayedTransparentRegionUpdate;->m_stageText:Lcom/adobe/air/AndroidStageText$AndroidStageTextImpl;

    .line 325
    iput-object p5, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText$DelayedTransparentRegionUpdate;->m_AIRSurface:Lcom/adobe/air/AIRWindowSurfaceView;

    .line 326
    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 330
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText$DelayedTransparentRegionUpdate;->m_stageText:Lcom/adobe/air/AndroidStageText$AndroidStageTextImpl;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText$DelayedTransparentRegionUpdate;->m_AIRSurface:Lcom/adobe/air/AIRWindowSurfaceView;

    if-eqz v0, :cond_0

    .line 332
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText$DelayedTransparentRegionUpdate;->m_stageText:Lcom/adobe/air/AndroidStageText$AndroidStageTextImpl;

    iget-object v1, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText$DelayedTransparentRegionUpdate;->m_AIRSurface:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v0, v1}, Lcom/adobe/air/AndroidStageText$AndroidStageTextImpl;->requestTransparentRegion(Landroid/view/View;)V

    .line 334
    :cond_0
    iget v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText$DelayedTransparentRegionUpdate;->m_nUpdates:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText$DelayedTransparentRegionUpdate;->m_nUpdates:I

    if-lez v0, :cond_1

    .line 335
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText$DelayedTransparentRegionUpdate;->m_stageText:Lcom/adobe/air/AndroidStageText$AndroidStageTextImpl;

    iget v1, p0, Lcom/adobe/air/AndroidStageText$AndroidStageTextEditText$DelayedTransparentRegionUpdate;->m_freqMsecs:I

    int-to-long v2, v1

    invoke-virtual {v0, p0, v2, v3}, Lcom/adobe/air/AndroidStageText$AndroidStageTextImpl;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 337
    :cond_1
    return-void
.end method
