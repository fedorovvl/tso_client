.class public Lcom/adobe/air/microphone/MobileAEC$AecmConfig;
.super Ljava/lang/Object;
.source "MobileAEC.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/microphone/MobileAEC;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "AecmConfig"
.end annotation


# instance fields
.field private mAecmMode:S

.field private mCngMode:S

.field final synthetic this$0:Lcom/adobe/air/microphone/MobileAEC;


# direct methods
.method public constructor <init>(Lcom/adobe/air/microphone/MobileAEC;)V
    .locals 1
    .param p1, "this$0"    # Lcom/adobe/air/microphone/MobileAEC;

    .prologue
    .line 318
    iput-object p1, p0, Lcom/adobe/air/microphone/MobileAEC$AecmConfig;->this$0:Lcom/adobe/air/microphone/MobileAEC;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 319
    sget-object v0, Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;->AGGRESSIVE:Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;

    invoke-virtual {v0}, Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;->getMode()I

    move-result v0

    int-to-short v0, v0

    iput-short v0, p0, Lcom/adobe/air/microphone/MobileAEC$AecmConfig;->mAecmMode:S

    .line 320
    const/4 v0, 0x1

    iput-short v0, p0, Lcom/adobe/air/microphone/MobileAEC$AecmConfig;->mCngMode:S

    return-void
.end method

.method static synthetic access$002(Lcom/adobe/air/microphone/MobileAEC$AecmConfig;S)S
    .locals 0
    .param p0, "x0"    # Lcom/adobe/air/microphone/MobileAEC$AecmConfig;
    .param p1, "x1"    # S

    .prologue
    .line 318
    iput-short p1, p0, Lcom/adobe/air/microphone/MobileAEC$AecmConfig;->mAecmMode:S

    return p1
.end method
