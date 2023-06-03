.class public final enum Lcom/adobe/air/wand/view/WandView$ScreenOrientation;
.super Ljava/lang/Enum;
.source "WandView.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/wand/view/WandView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "ScreenOrientation"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/adobe/air/wand/view/WandView$ScreenOrientation;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

.field public static final enum AUTO:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

.field public static final enum INHERIT:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

.field public static final enum LANDSCAPE:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

.field public static final enum PORTRAIT:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

.field public static final enum REVERSE_LANDSCAPE:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

.field public static final enum REVERSE_PORTRAIT:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;


# instance fields
.field private final mOrientation:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 9

    .prologue
    const/4 v8, 0x4

    const/4 v7, 0x3

    const/4 v6, 0x2

    const/4 v5, 0x1

    const/4 v4, 0x0

    .line 29
    new-instance v0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    const-string v1, "LANDSCAPE"

    const-string v2, "LANDSCAPE"

    invoke-direct {v0, v1, v4, v2}, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->LANDSCAPE:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    .line 30
    new-instance v0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    const-string v1, "PORTRAIT"

    const-string v2, "PORTRAIT"

    invoke-direct {v0, v1, v5, v2}, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->PORTRAIT:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    .line 31
    new-instance v0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    const-string v1, "REVERSE_LANDSCAPE"

    const-string v2, "REVERSE_LANDSCAPE"

    invoke-direct {v0, v1, v6, v2}, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->REVERSE_LANDSCAPE:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    .line 32
    new-instance v0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    const-string v1, "REVERSE_PORTRAIT"

    const-string v2, "REVERSE_PORTRAIT"

    invoke-direct {v0, v1, v7, v2}, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->REVERSE_PORTRAIT:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    .line 34
    new-instance v0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    const-string v1, "AUTO"

    const-string v2, "AUTO"

    invoke-direct {v0, v1, v8, v2}, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->AUTO:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    .line 35
    new-instance v0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    const-string v1, "INHERIT"

    const/4 v2, 0x5

    const-string v3, "INHERIT"

    invoke-direct {v0, v1, v2, v3}, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->INHERIT:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    .line 27
    const/4 v0, 0x6

    new-array v0, v0, [Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    sget-object v1, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->LANDSCAPE:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    aput-object v1, v0, v4

    sget-object v1, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->PORTRAIT:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    aput-object v1, v0, v5

    sget-object v1, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->REVERSE_LANDSCAPE:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    aput-object v1, v0, v6

    sget-object v1, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->REVERSE_PORTRAIT:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    aput-object v1, v0, v7

    sget-object v1, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->AUTO:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    aput-object v1, v0, v8

    const/4 v1, 0x5

    sget-object v2, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->INHERIT:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    aput-object v2, v0, v1

    sput-object v0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->$VALUES:[Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0
    .param p3, "orientation"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    .line 37
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 38
    iput-object p3, p0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->mOrientation:Ljava/lang/String;

    .line 39
    return-void
.end method

.method public static getScreenOrientation(Ljava/lang/String;)Lcom/adobe/air/wand/view/WandView$ScreenOrientation;
    .locals 2
    .param p0, "orientation"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 50
    sget-object v0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->LANDSCAPE:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    invoke-virtual {v0}, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 51
    sget-object v0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->LANDSCAPE:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    .line 66
    :goto_0
    return-object v0

    .line 53
    :cond_0
    sget-object v0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->PORTRAIT:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    invoke-virtual {v0}, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 54
    sget-object v0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->PORTRAIT:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    goto :goto_0

    .line 56
    :cond_1
    sget-object v0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->REVERSE_LANDSCAPE:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    invoke-virtual {v0}, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 57
    sget-object v0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->REVERSE_LANDSCAPE:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    goto :goto_0

    .line 59
    :cond_2
    sget-object v0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->REVERSE_PORTRAIT:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    invoke-virtual {v0}, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 60
    sget-object v0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->REVERSE_PORTRAIT:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    goto :goto_0

    .line 62
    :cond_3
    sget-object v0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->AUTO:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    invoke-virtual {v0}, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 63
    sget-object v0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->AUTO:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    goto :goto_0

    .line 65
    :cond_4
    sget-object v0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->INHERIT:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    invoke-virtual {v0}, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 66
    sget-object v0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->INHERIT:Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    goto :goto_0

    .line 69
    :cond_5
    new-instance v0, Ljava/lang/Exception;

    const-string v1, "Unspported screen orientation"

    invoke-direct {v0, v1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/adobe/air/wand/view/WandView$ScreenOrientation;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 27
    const-class v0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    return-object v0
.end method

.method public static values()[Lcom/adobe/air/wand/view/WandView$ScreenOrientation;
    .locals 1

    .prologue
    .line 27
    sget-object v0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->$VALUES:[Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    invoke-virtual {v0}, [Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/adobe/air/wand/view/WandView$ScreenOrientation;

    return-object v0
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 1

    .prologue
    .line 45
    iget-object v0, p0, Lcom/adobe/air/wand/view/WandView$ScreenOrientation;->mOrientation:Ljava/lang/String;

    return-object v0
.end method
