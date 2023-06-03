.class public final Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;
.super Ljava/lang/Object;
.source "MobileAEC.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/microphone/MobileAEC;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "AggressiveMode"
.end annotation


# static fields
.field public static final AGGRESSIVE:Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;

.field public static final HIGH:Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;

.field public static final MEDIUM:Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;

.field public static final MILD:Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;

.field public static final MOST_AGGRESSIVE:Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;


# instance fields
.field private final mMode:I


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 76
    new-instance v0, Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;-><init>(I)V

    sput-object v0, Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;->MILD:Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;

    .line 82
    new-instance v0, Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;-><init>(I)V

    sput-object v0, Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;->MEDIUM:Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;

    .line 88
    new-instance v0, Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;-><init>(I)V

    sput-object v0, Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;->HIGH:Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;

    .line 94
    new-instance v0, Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;

    const/4 v1, 0x3

    invoke-direct {v0, v1}, Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;-><init>(I)V

    sput-object v0, Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;->AGGRESSIVE:Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;

    .line 100
    new-instance v0, Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;

    const/4 v1, 0x4

    invoke-direct {v0, v1}, Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;-><init>(I)V

    sput-object v0, Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;->MOST_AGGRESSIVE:Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;

    return-void
.end method

.method private constructor <init>(I)V
    .locals 0
    .param p1, "mode"    # I

    .prologue
    .line 105
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 106
    iput p1, p0, Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;->mMode:I

    .line 107
    return-void
.end method


# virtual methods
.method public getMode()I
    .locals 1

    .prologue
    .line 70
    iget v0, p0, Lcom/adobe/air/microphone/MobileAEC$AggressiveMode;->mMode:I

    return v0
.end method
